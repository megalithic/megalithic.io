// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
// const defaultTheme = require("tailwindcss/defaultTheme");

const { fontFamily } = require("tailwindcss/defaultTheme");
module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  darkMode: "class",
  mode: "jit",
  theme: {
    extend: {
      fontFamily: {
        url: "https://rsms.me/inter/inter.css",
        sans: ['"Inter var"', "Inter", ...fontFamily.sans],
        mono: ['"Fira Code VF"', '"Fira Code"', ...fontFamily.mono],
        // "sans": ["Inter", "sans-serif"],
        // "sans-variation": ["Inter var", "sans-serif"],
      },
      container: {
        center: true,
      },
    },
  },
  plugins: [],
};
