
import compose from './compose'

export default (middlewares...) ->

	fn = compose middlewares

	handle = (event) ->
		app = {}
		app.input = event

		try
			fn app
		catch error
			if callback
				callback error, if error.getData then error.getData()
				return
			else
				throw error

		return app.output

	return handle
