share.Categories = window.Categories = new Meteor.Collection(null,
  transform: share.Transformations.Category
)
share.Tools = window.Tools = new Meteor.Collection(null,
  transform: share.Transformations.Tool
)