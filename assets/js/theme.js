window.updateTheme = function(theme) {
  switch(theme) {
    case "light":
      localStorage.theme = "light"
      document.documentElement.classList.remove("dark")
      break;
    case "dark":
      localStorage.theme = "dark"
      document.documentElement.classList.add("dark")
      break;
    default:
      localStorage.removeItem('theme')
      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.classList.add("dark")
      } else {
        document.documentElement.classList.remove("dark")
      }
      break;
  }
}

window.themeChooser = function() {
  const currentTheme = localStorage.theme || "system"
  return {
    colorThemes: ['dark', 'light', 'system'],
    currentTheme: currentTheme
  }
}

window.matchMedia('(prefers-color-scheme: dark)').addListener(e => {
  // untested
  if (localStorage.theme) { return }
  if (e.matches) {
    document.documentElement.classList.add('dark')
  } else {
    document.documentElement.classList.remove('dark')
  }
});

const chooser = document.getElementById("themeChooser")

if (chooser) {
  chooser.onchange = (e) => updateTheme(e.target.value)
  let { currentTheme, colorThemes } = themeChooser()
  colorThemes.forEach((colorTheme) => {
    let option = document.createElement("option")
    option.value = colorTheme
    option.textContent = colorTheme
    option.selected = currentTheme == colorTheme
    chooser.appendChild(option)
  })
  updateTheme(currentTheme)
}
