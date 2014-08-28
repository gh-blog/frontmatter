through2 = require 'through2'
frontmatter = require 'front-matter'

# requires ['html']
# should run before 'markdown'

module.exports = (options) ->
    processFile = (file, enc, done) ->
        if file.isPost
            text = String file.contents
            result = frontmatter text

            if result.body
                file.contents = new Buffer result.body

            for key, value in result.attributes
                file[key] = value

        done null, file

    through2.obj processFile