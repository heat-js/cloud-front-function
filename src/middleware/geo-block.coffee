
import { stringify } from 'querystring'

export default (countries = [], ips = [])->
	return (app, next) ->
		{ request, viewer } = app.input

		userIp 	= viewer.ip
		country = request.headers['cloudfront-viewer-country'].value

		# ---------------------------------------------------------
		# Normalize querystring

		querystring = {}
		for key, { value } of request.querystring
			querystring[key] = value

		# ---------------------------------------------------------
		# Redirect a blocked country to a restricted version of the page

		if countries.includes(country) and (querystring.restricted isnt country) and not ips.includes(userIp)
			querystring.restricted = country

			url = [
				'https://'
				request.headers.host?.value
				request.uri
				'?' + stringify querystring
			]

			app.output = {
				statusCode: 		302
				statusDescription: 	'Redirecting to restricted domain'
				headers: {
					location: {
						value: url.join ''
					}
				}
			}
			return

		# ---------------------------------------------------------
		# Redirect a non-blocked country or a whitelisted ip
		# to a non restricted version of the page.

		if (not countries.includes(country) or ips.includes(userIp)) and querystring.restricted
			delete querystring.restricted

			url = [
				'https://'
				request.headers.host?.value
				request.uri
			]

			if Object.keys(querystring).length
				url.push '?' + stringify querystring

			app.output = {
				statusCode: 		302
				statusDescription: 	'Redirecting to non-restricted domain'
				headers: {
					location: {
						value: url.join ''
					}
				}
			}
			return


		next app
