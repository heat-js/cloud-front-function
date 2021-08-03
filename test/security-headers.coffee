
import handle 			from '../src/handle'
import SecurityHeaders 	from '../src/middleware/security-headers'

describe 'Security Headers', ->
	cfFunction = handle(
		new SecurityHeaders {
			'server':						'ColdFusion X8ZZ1'
			'strict-transport-security':	[ 'max-age=63072000', 'preload']
			'x-content-type-options':		'nosniff'
			'feature-policy': {
				'autoplay': 		"'self'"
				'camera': 			"'none'"
				'encrypted-media':	"'none'"
				'fullscreen': 		"'self'"
			}
		}
		(app) ->
			app.output = app.input.response
	)

	it 'should test the output', ->
		headers = {
			'x-amz-meta-x-content-type-options': {
				value: 'REPLACED'
			}
		}

		result = await cfFunction {
			response: { headers, statusCode: 200 }
		}

		expect result
			.toStrictEqual {
				statusCode: 200
				headers: {
					'server': {
						value: 'ColdFusion X8ZZ1'
					}
					'strict-transport-security': {
						value: 'max-age=63072000; preload'
					}
					'feature-policy': {
						value: "autoplay 'self'; camera 'none'; encrypted-media 'none'; fullscreen 'self'"
					}
					'x-content-type-options': {
						value: 'REPLACED'
					}
				}
			}
