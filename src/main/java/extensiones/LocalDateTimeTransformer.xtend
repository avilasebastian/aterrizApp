package extensiones

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException
import org.apache.commons.lang.StringUtils
import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

/**
 * <p>
 * <code>Transformer</code> que sirve parra recibir un texto y convertirlo en <code>LocalDate</code>
 * o viceversa. En caso de error devuelve <code>UserException</code>. En caso de recibir una cadena
 * vacía devuelve <code>LocalDateTime referenceValue</code>
 * </p>
 * <p>
 * {@link #viewToModel(String)} Toma el valor provisto y lo convierte en <code>LocalDateTime</code><br>
 * {@link #modelToView(LocalDateTime)} Toma el valor provisto y lo convierte en <code>String</code><br>
 * {@link #getModelType()} Devuelve el tipo de clase de entrada <code>LocalDateTime</code><br>
 * {@link #getViewType()} Devuelve el tipo de clase de salida <code>LocalDateTime</code><br>
 * </p>
 * **/
class LocalDateTimeTransformer implements ValueTransformer<LocalDateTime, String> {
	var String patternIn = "dd/MM/uuuu"
	var String patternOut = "dd/MM/uuuu - HH:mm"

	var DateTimeFormatter formatter = DateTimeFormatter.ofPattern(patternOut)

	var LocalDateTime referenceValue

	new(LocalDateTime referenceValue) {
		this.referenceValue = referenceValue
	}

	override LocalDateTime viewToModel(String valueFromView) {
		try {
			var LocalDateTime InternalRetorno

			if (StringUtils.isBlank(valueFromView))
				InternalRetorno = referenceValue
			else
				InternalRetorno = LocalDateTime.parse(valueFromView + " - 00:00", formatter)

			return InternalRetorno

		} catch (DateTimeParseException e) { // TODO: i18n
			throw new UserException("Debe ingresar una fecha en formato: " + this.patternIn)
		}
	}

	override String modelToView(LocalDateTime valueFromModel) {
		// SQL Server (es el que tiene el rango más pequeño)
		var LocalDateTime minimum = LocalDateTime.of(1900, 01, 01, 00, 0, 0)
		var LocalDateTime maximum = LocalDateTime.of(2079, 06, 06, 00, 0, 0)
		var String InternalRetorno

		if (valueFromModel.equals(minimum) || valueFromModel.equals(maximum))
			InternalRetorno = ""
		else
			InternalRetorno = valueFromModel.format(formatter)

		return InternalRetorno
	}

	override Class<LocalDateTime> getModelType() {
		typeof(LocalDateTime)
	}

	override Class<String> getViewType() {
		typeof(String)
	}
}
