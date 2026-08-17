// Cloudflare Pages Function. Writes search queries to the SEARCH_LOG_DB D1
// database for internal content-gap research only (same pattern as
// knowyourisms.com's log-search.ts, 2026-08-16 decision: Pagefind + D1
// everywhere on Cloudflare-hosted sites, Vercel Postgres for Uncle Nobody).
//
// Fails silently rather than erroring when the D1 binding is absent: no
// binding yet means no-op, not a 500.

interface D1ResultLike {
  success: boolean;
}

interface D1PreparedStatementLike {
  bind(...values: unknown[]): D1PreparedStatementLike;
  run(): Promise<D1ResultLike>;
}

interface D1DatabaseLike {
  prepare(query: string): D1PreparedStatementLike;
}

interface PagesFunctionContext {
  request: Request;
  env: { SEARCH_LOG_DB?: D1DatabaseLike };
}

function normalizeQuery(query: string): string {
  return query.trim().toLowerCase().replace(/\s+/g, " ");
}

export async function onRequestPost(context: PagesFunctionContext): Promise<Response> {
  try {
    const db = context.env.SEARCH_LOG_DB;
    if (!db) return new Response(null, { status: 204 });

    const body = (await context.request.json()) as {
      query?: unknown;
      timestamp?: unknown;
      resultsCount?: unknown;
    };
    const query = typeof body.query === "string" ? body.query.trim().slice(0, 500) : "";
    if (!query) return new Response(null, { status: 204 });

    const timestamp = typeof body.timestamp === "string" ? body.timestamp : new Date().toISOString();
    const resultsCount = typeof body.resultsCount === "number" ? body.resultsCount : 0;

    await db
      .prepare(
        "INSERT INTO search_log (timestamp, site, query_raw, query_normalized, results_count) VALUES (?, ?, ?, ?, ?)"
      )
      .bind(timestamp, "tripprintables.com", query, normalizeQuery(query), resultsCount)
      .run();

    return new Response(null, { status: 204 });
  } catch {
    return new Response(null, { status: 204 });
  }
}
