
export default (encodedAuthString) ->
	return (app, next) ->
		{ request } = app.input

		if request?.headers?.authorization?.value isnt 'Basic ' + encodedAuthString
			app.output = {
				statusCode: 		401
				statusDescription: 	'Unauthorized'
				headers: {
					'www-authenticate': {
						value: 'Basic'
					}
				}
			}
			return

		next app


# import Middleware from './abstract'

# export default class BasicAuth extends Middleware

# 	constructor: (@username, @password) ->
# 		super()

# 	handle: (app, next) ->
# 		await next app
