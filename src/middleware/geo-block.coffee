
import Middleware from './abstract'

export default class GeoBlock extends Middleware

	constructor: (@countries = []) ->
		super()

	handle: (app, next) ->
		# countryCode = request.headers['cloudfront-viewer-country'].value

		# if app.config.geo.blacklist.includes countryCode
		# 	request.headers.value1 = [{ value: String request.uri.includes('.') }]
		# 	request.headers.value2 = [{ value: String request.uri.includes('.html') }]
		# 	if not request.uri.includes('.') or request.uri.includes('.html')
		# 		request.uri = '/online/'

			# url = [
			# 	'https://'
			# 	request.headers.host[0].value
			# 	'/restricted'
			# 	request.uri
			# ].join ''

			# app.output = {
			# 	status: 302
			# 	statusDescription: 'Restricted'
			# 	headers: {
			# 		location: [{
			# 			key: 	'Location'
			# 			value: 	url
			# 		}]
			# 	}
			# }
			# return
