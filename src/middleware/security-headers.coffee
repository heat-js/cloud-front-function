
export default (defaultHeaders = {}) ->
	return (app, next) ->
		{ response } = app.input

		# ---------------------------------------------------------
		# Set default security headers

		for key, value of defaultHeaders
			if value is false
				delete response.headers[key]
				continue

			if Array.isArray value
				value = value.join '; '

			else if typeof value is 'object'
				directives = []
				for directiveKey, directiveValue of value
					if directiveValue is true
						directives.push directiveKey
						continue

					if Array.isArray directiveValue
						directiveValue = directiveValue.join ' '

					directives.push "#{directiveKey} #{directiveValue}"

				value = directives.join '; '

			response.headers[key] = { value }

		# ---------------------------------------------------------
		# Set or override headers beginning with x-amz-meta

		prefix = 'x-amz-meta-'

		for key, { value } of response.headers
			if prefix is key.slice 0, prefix.length
				stripped = key.slice prefix.length

				response.headers[stripped] = {
					value
				}

				delete response.headers[key]

		next app



# import Middleware from './abstract'

# export default class SecurityHeaders extends Middleware

# 	constructor: (@headers = {}) ->
# 		super()

# 	handle: (app, next) ->
