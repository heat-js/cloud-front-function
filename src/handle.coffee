
import compose from './compose'

export default (middlewares...) ->

	fn = compose middlewares

	# ----------------------------------------------------

	handle = (input, context = {}, callback) ->

		app = {}
		app.context  = context
		app.input 	 = input
		app.callback = callback

		# ----------------------------------------------------
		# Run composed middleware functions.

		try
			fn app
		catch error
			if callback
				callback error, if error.getData then error.getData()
				return
			else
				throw error

		# ----------------------------------------------------
		# Handle response.

		# Support for the old callback function.
		if callback
			callback null, app.output
			return

		return app.output

	return handle
