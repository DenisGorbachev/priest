categories = [
  {
    name: "Converters"
    slug: "convert"
  }
  {
    name: "Formatters"
    slug: "format"
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
    from: "HTML"
    to: "Jade"
    categoryId: categorySlug2Id["convert"]
    type: "converter"
    isActive: true
  }
  {
    from: "JavaScript"
    to: "CoffeeScript"
    categoryId: categorySlug2Id["convert"]
    type: "converter"
    template: "js2coffee"
    isActive: true
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
    categoryId: categorySlug2Id["format"]
    isActive: false
  }
  {
    name: "CSS"
    slug: "css"
    categoryId: categorySlug2Id["format"]
    isActive: false
  }
  {
    name: "HTML"
    slug: "html"
    categoryId: categorySlug2Id["format"]
    isActive: false
  }
  {
    name: "Handlebars"
    slug: "handlebars"
    categoryId: categorySlug2Id["format"]
    isActive: false
  }
  {
    name: "Jade"
    slug: "jade"
    categoryId: categorySlug2Id["format"]
    isActive: false
  }
  {
    name: "JavaScript"
    slug: "javascript"
    categoryId: categorySlug2Id["format"]
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