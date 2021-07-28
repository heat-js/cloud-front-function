
import Middleware from './abstract'

export default class BasicAuth extends Middleware

	constructor: (@username, @password) ->
		super()

	handle: (app, next) ->
		{ request } = app.input

		authString = 'Basic ' + Buffer.from(@username + ':' + @password, 'utf-8').toString 'base64'

		if request?.headers?.authorization?.value isnt authString
			app.output = {
				statusCode: 		401
				statusDescription: 	'Unauthorized'
				body: 				'Unauthorized'
				headers: {
					'www-authenticate': {
						value: 'Basic'
					}
				}
			}
			return

		await next app
