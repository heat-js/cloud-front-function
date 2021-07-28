
export default ->
	return (app, next) ->
		{ request } = app.input

		host = request.headers.host.value

		if host.startsWith 'www.'
			app.output = {
				statusCode: 		301
				statusDescription: 	'Redirecting to apex domain'
				headers: {
					location: {
						value: "https://#{ host.substr 4 }#{ request.uri }"
					}
				}
			}
			return

		next app

# import Middleware from './abstract'

# export default class ForceNonWww extends Middleware

# 	handle: (app, next) ->
# 		{ request } = app.input

# 		host = request.headers.host.value

# 		if host.startsWith 'www.'
# 			app.output = {
# 				statusCode: 		301
# 				statusDescription: 	'Redirecting to apex domain'
# 				headers: {
# 					location: {
# 						value: "https://#{ host.substr 4 }#{ request.uri }"
# 					}
# 				}
# 			}
# 			return

# 		await next app
