categories = [
  {
    name: "Converters"
    slug: "convert"
  }
  {
    name: "Beautifiers"
    slug: "beautify"
  }
]
categorySlug2Id = []

for category in categories
  categorySlug2Id[category.slug] = share.Categories.insert(category)

tools = [
  {
    name: "CSS to LESS"
    slug: "css-to-less"
    categoryId: categorySlug2Id["convert"]
    isActive: false
  }
  {
    from: "CSS"
    to: "Stylus"
    categoryId: categorySlug2Id["convert"]
    type: "converter"
    isActive: true
  }
  {
    name: "HTML to Jade"
    slug: "html-to-jade"
    categoryId: categorySlug2Id["convert"]
    isActive: false
  }
  {
    name: "JavaScript to CoffeeScript"
    slug: "javascript-to-coffeescript"
    categoryId: categorySlug2Id["convert"]
    isActive: false
  }
  {
    name: "Spacebars to Jade"
    slug: "spacebars-to-jade"
    categoryId: categorySlug2Id["convert"]
    isActive: false
  }
  {
    name: "CoffeeScript"
    slug: "coffeescript"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
  {
    name: "CSS"
    slug: "css"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
  {
    name: "HTML"
    slug: "html"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
  {
    name: "Handlebars"
    slug: "handlebars"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
  {
    name: "Jade"
    slug: "jade"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
  {
    name: "JavaScript"
    slug: "javascript"
    categoryId: categorySlug2Id["beautify"]
    isActive: false
  }
]

for tool in tools
  share.Tools.insert(tool)

#  {
#    name: "Testers"
#    slug: "testers"
#  }
#  {
#    name: "Pickers"
#    slug: "pickers"
#  }

# pickers
#  {
#    name: "Character"
#    slug: "character"
#    categorySlug: "pickers"
#    isActive: true
#  }
#  {
#    name: "Color"
#    slug: "color"
#    categorySlug: "pickers"
#    isActive: false
#  }
# testers
#  {
#    name: "Regex"
#    slug: "regex"
#    categorySlug: "testers"
#    isActive: false
#  }
#  {
#    name: "Xpath"
#    slug: "xpath"
#    categorySlug: "testers"
#    isActive: false
#  }
#  {
#    name: "SQL"
#    slug: "sql"
#    categorySlug: "testers"
#    isActive: false
#  }