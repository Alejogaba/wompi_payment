import 'dart:convert';

import 'package:wompi_pago/src/adapters/http_client.dart';
import 'package:wompi_pago/src/models/object_models/credit_card_model.dart';
import 'package:wompi_pago/src/models/object_models/payment_request_model.dart';
import 'package:wompi_pago/src/models/response_models/respuesta_pago_tarjeta.dart';
import 'package:wompi_pago/src/models/response_models/tarjeta_tokenizada.dart';
import 'package:wompi_pago/src/payment_methods/payment_processor.dart';
import 'package:wompi_pago/src/services/wompi_client.dart';

/// **_PAGAR POR MEDIO DE TARJETA DE CRÉDITO_**
///
class CreditCardPay extends PaymentProcessor {
  final CreditCard creditCard;

  CreditCardPay(
      {required this.creditCard,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest, wompiClient);

  @override
  Future<RespuestaPagoTarjeta> pay() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/tokens/cards";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer' + wompiClient.llavePublica
    };

    Map<String, dynamic> body = {
      'number': creditCard.cardNumber,
      'cvc': creditCard.cvcCode,
      'exp_month': creditCard.expMonth,
      'exp_year': creditCard.expYear,
      'card_holder': creditCard.cardHolder
    };

    // TOKENIZAR TARJETA DE CRÉDITO
    var response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    final tarjeta = TarjetaTokenizada.fromJson(json.decode(response.body));

    final tokenTarjeta = tarjeta.data.id;

    // GENERAR PAGO
    urlCompleta = "$url/v1/transactions/";

    headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $wompiClient.llavePublica'
    };

    body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.llavePublica,
      'amount_in_cents': creditCard.amount * 100,
      'reference': wompiClient.prefijoComercio + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.moneda,
      'payment_method': {
        'type': 'CARD',
        'installments': creditCard.quotas,
        'token': tokenTarjeta
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    final respuestaPago =
        RespuestaPagoTarjeta.fromJson(json.decode(response.body));
    return respuestaPago;
  }
}