module.exports = ({ env }) => ({
  plugins: {
    "postcss-import": {},
    "tailwindcss/nesting": {},
    "tailwindcss": {},
    "autoprefixer": {},
    // optimisations: https://cssnano.co/docs/optimisations
    "cssnano": env === "production" ? { preset: "default" } : false,
  },
});
