// import "../vendor/syntax";
import "../vendor/highlighter";

let Hooks = {};

// Hooks.Highlight = {
//   mounted() {
//     window.highlightAll(this.el);
//   },
// };

Hooks.Highlight = {
  mounted() {
    // Shiki();
    window.highlightAll(this.el);
  },
};

export default Hooks;
