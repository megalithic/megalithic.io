const shiki = require("shiki");

// function highlight(code, lang) {
//   if (lang) {
//     try {
//       const tokens = highlighter.codeToThemedTokens(code, lang);
//       return tokens.map((line, num) =>
//         // jsx("span", {
//         //   "data-line": num + 1,
//         //   "children": [
//         //     ...line.map((token) =>
//         //       /^\w*$/.test(token)
//         //         ? token
//         //         : jsx("span", {
//         //             style: {
//         //               "color": token.color,
//         //               "font-style": token.fontStyle & shiki.FontStyle.Italic ? "italic" : null,
//         //             },
//         //             children: token.content,
//         //           })
//         //     ),
//         //     "\n",
//         //   ],
//         // })
//     } catch {
//       // Ignore
//     }
//   }
//   // Otherwise return unhighlighted code text
//   return code;
// }

window.highlightAll = function (where = document) {
  // const highlighter = shiki.getHighlighter({
  //   theme: "nord",
  // });
  // .then((highlighter) => {
  //   // console.log(highlighter.codeToHtml(`console.log('shiki');`, { lang: "bash" }));
  //   // console.log(highlighter.codeToHtml(`console.log('shiki');`, { lang: "js" }));
  //   const code = highlighter.codeToHtml(`console.log('shiki');`, {});
  //   document.getElementById("output").innerHTML = code;
  // });

  shiki
    .getHighlighter({
      theme: "nord",
    })
    .then((highlighter) => {
      // console.log(highlighter.codeToHtml(`console.log('shiki');`, { lang: "bash" }));
      // console.log(highlighter.codeToHtml(`console.log('shiki');`, { lang: "js" }));
      // const code = highlighter.codeToHtml(`console.log('shiki');`, {});
      // document.getElementById("output").innerHTML = code;

      where.querySelectorAll("pre code").forEach((code) => {
        const lang = code.getAttribute("class");
        if (lang && lang !== "makeup elixir") {
          console.log({ lang, code });
          const highlighted = highlighter.codeToHtml(code, { lang: lang });
          console.log({ highlighted });
          // const { value: value } = highlight(block.innerText, lang );
          code.innerHTML = highlighted;
        }
      });
    });
};
window.highlightAll();

// export default Shiki;
