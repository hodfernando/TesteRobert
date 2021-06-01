import * as functions from "firebase-functions";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions
//     .region("southamerica-east1")
//     .https
//     .onRequest((request, response) => {
//       functions.logger.info("Teste!", {structuredData: true});
//       response.send("Quanto tempo demora!");
//     });

import admin = require("firebase-admin");
admin.initializeApp();

exports.arquivaOperacoes = functions
    .region("southamerica-east1")
    .firestore
    .document("/valores/{docId}")
    .onCreate( async (snap, context) => {
      const docId = context.params.docId;
      const data = snap.data();
      const message = data.mensagem;
      const uid = data.uid;
      const value = data.valor;
      functions.logger.log("Documento:", docId);
      functions.logger.log("Identidade do usuário", uid);
      functions.logger.log("Valor da transação", value);
      functions.logger.log("Mensagem", message);
      const todayAsTimestamp = admin.firestore.Timestamp.now();
      const writeResult = await admin.firestore().collection("atividades")
          .add({docId: docId, uid: uid, value: value, time: todayAsTimestamp});
      functions.logger.log("Message with ID:", writeResult.id, "added.");
    });
