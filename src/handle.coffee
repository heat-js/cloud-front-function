
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
			await fn app

		catch error

			# Lambda supports errors with extra data.
			if callback
				callback error, if error.getData then error.getData()
				return
			else
				throw error

		# ----------------------------------------------------
		# Handle response.

		output = if app.has 'output'
			app.output

		# Support for the old callback function.
		if callback
			callback null, output
			return

		return output

	return handle
