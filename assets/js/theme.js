// NOTE: this gives you select options included "system";
//
// window.updateTheme = function (theme) {
//   switch (theme) {
//     case "light":
//       localStorage.theme = "light";
//       document.documentElement.classList.remove("dark");
//       break;
//     case "dark":
//       localStorage.theme = "dark";
//       document.documentElement.classList.add("dark");
//       break;
//     default:
//       localStorage.removeItem("theme");
//       if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
//         document.documentElement.classList.add("dark");
//       } else {
//         document.documentElement.classList.remove("dark");
//       }
//       break;
//   }
// };

// window.themeChooser = function () {
//   const currentTheme = localStorage.theme || "system";
//   return {
//     colorThemes: ["dark", "light", "system"],
//     currentTheme: currentTheme,
//   };
// };

// window.matchMedia("(prefers-color-scheme: dark)").addListener((e) => {
//   // untested
//   if (localStorage.theme) {
//     return;
//   }
//   if (e.matches) {
//     document.documentElement.classList.add("dark");
//   } else {
//     document.documentElement.classList.remove("dark");
//   }
// });

// const chooser = document.getElementById("themeChooser");

// if (chooser) {
//   chooser.onchange = (e) => updateTheme(e.target.value);
//   let { currentTheme, colorThemes } = themeChooser();
//   colorThemes.forEach((colorTheme) => {
//     let option = document.createElement("option");
//     option.value = colorTheme;
//     option.textContent = colorTheme;
//     option.selected = currentTheme == colorTheme;
//     chooser.appendChild(option);
//   });
//   updateTheme(currentTheme);
// }

// -----------------------------------------------------------------------------

// NOTE: this gives you a fancy svg based button toggler
//
var themeToggleDarkIcon = document.getElementById("theme-toggle-dark-icon");
var themeToggleLightIcon = document.getElementById("theme-toggle-light-icon");

// Change the icons inside the button based on previous settings
if (
  localStorage.getItem("theme") === "dark" ||
  (!("theme" in localStorage) && window.matchMedia("(prefers-color-scheme: dark)").matches)
) {
  themeToggleLightIcon.classList.remove("hidden");
} else {
  themeToggleDarkIcon.classList.remove("hidden");
}

var themeToggleBtn = document.getElementById("theme-toggle");

themeToggleBtn.addEventListener("click", function () {
  // toggle icons inside button
  themeToggleDarkIcon.classList.toggle("hidden");
  themeToggleLightIcon.classList.toggle("hidden");

  // if set via local storage previously
  if (localStorage.getItem("theme")) {
    if (localStorage.getItem("theme") === "light") {
      document.documentElement.classList.add("dark");
      localStorage.setItem("theme", "dark");
    } else {
      document.documentElement.classList.remove("dark");
      localStorage.setItem("theme", "light");
    }

    // if NOT set via local storage previously
  } else {
    if (document.documentElement.classList.contains("dark")) {
      document.documentElement.classList.remove("dark");
      localStorage.setItem("theme", "light");
    } else {
      document.documentElement.classList.add("dark");
      localStorage.setItem("theme", "dark");
    }
  }
});
