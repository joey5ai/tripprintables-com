module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy("src/css");
  eleventyConfig.addPassthroughCopy("src/js");
  eleventyConfig.addPassthroughCopy("src/images");
  eleventyConfig.addPassthroughCopy({ "src/static/llms.txt": "llms.txt" });
  eleventyConfig.addPassthroughCopy({ "src/static/favicon.ico": "favicon.ico" });

  eleventyConfig.addFilter("year", () => new Date().getFullYear());

  // Appends the " - Trip Printables" brand suffix to every page's <title>
  // except the homepage (which already carries the full brand title) and
  // any title that already ends with the brand name in some form (to
  // avoid double-appending it).
  const BRAND = "Trip Printables";
  eleventyConfig.addFilter("pageTitle", (title, url) => {
    if (!title) return title;
    if (url === "/") return title;
    if (title.trim().endsWith(BRAND)) return title;
    return `${title} - ${BRAND}`;
  });

  return {
    dir: {
      input: "src",
      includes: "_includes",
      data: "_data",
      output: "_site",
    },
    templateFormats: ["njk", "md"],
    htmlTemplateEngine: "njk",
    markdownTemplateEngine: "njk",
  };
};
