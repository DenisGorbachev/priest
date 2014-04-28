share.Categories = window.Categories = new Meteor.Collection(null,
  transform: share.Transformations.category
)
share.Tools = window.Tools = new Meteor.Collection(null,
  transform: share.Transformations.tool
)