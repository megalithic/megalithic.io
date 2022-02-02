// import hljs from "highlight.js";
// import "highlight.js/styles/github.css";

import hljs from "highlight.js/lib/core";

import javascript from "highlight.js/lib/languages/javascript";
import shell from "highlight.js/lib/languages/shell";
import bash from "highlight.js/lib/languages/bash";
import erb from "highlight.js/lib/languages/erb";
import ruby from "highlight.js/lib/languages/ruby";
import vim from "highlight.js/lib/languages/vim";
import yaml from "highlight.js/lib/languages/yaml";
import json from "highlight.js/lib/languages/json";
import diff from "highlight.js/lib/languages/diff";
import xml from "highlight.js/lib/languages/xml";
import sql from "highlight.js/lib/languages/sql";
import lua from "highlight.js/lib/languages/lua";
import ini from "highlight.js/lib/languages/ini";
import markdown from "highlight.js/lib/languages/markdown";

hljs.registerLanguage("javascript", javascript);
hljs.registerLanguage("shell", shell);
hljs.registerLanguage("bash", bash);
hljs.registerLanguage("eex", erb);
hljs.registerLanguage("ruby", ruby);
hljs.registerLanguage("vim", vim);
hljs.registerLanguage("yaml", yaml);
hljs.registerLanguage("json", json);
hljs.registerLanguage("diff", diff);
hljs.registerLanguage("html", xml);
hljs.registerLanguage("sql", sql);
hljs.registerLanguage("lua", lua);
hljs.registerLanguage("ini", ini);
hljs.registerLanguage("markdown", markdown);

window.highlightAll = function (where = document) {
  where.querySelectorAll("pre code").forEach((block) => {
    const lang = block.getAttribute("class");
    if (lang && lang !== "makeup elixir") {
      const { value: value } = hljs.highlight(block.innerText, { language: lang });
      block.innerHTML = value;
    }
  });
};

window.highlightAll();
