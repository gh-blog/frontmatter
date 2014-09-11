through2 = require 'through2'
frontmatter = require 'front-matter'
path = require 'path'

mdRegExp = /.md|.mdown|.markdown|.gfm/i

module.exports = (options) ->
    processFile = (file, enc, done) ->
        if file.isPost and path.extname(file.path).match mdRegExp
            text = String file.contents
            result = frontmatter text

            if result.body
                file.contents = new Buffer result.body

            for key, value of result.attributes
                file[key] = value

        done null, file

    through2.obj processFile