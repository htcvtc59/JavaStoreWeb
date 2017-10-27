const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp(functions.config().firebase)
const express = require('express')
const app = express()
var db = admin.database()
app.get('/:name/:email/:phone', (req, res) => {
    var name = req.params.name
    var email = req.params.email
    var phone = req.params.phone
    db.ref('/').push().set({ name: name, email: email, phone: phone })
        .then(() => db.ref('/').limitToLast(1).on('child_added', (snapshot) => {
            res.send({ key: snapshot.key, value: snapshot.val() })
        }))
        .catch(error => res.send(error))
})

app.get('/app/:key/:name/:message', (req, res) => {
    var key = req.params.key
    var name = req.params.name
    var message = req.params.message

    db.ref('/' + key + '/messages').push().set({ name: name, message: message, signup: new Date().getTime() })
        .then(() => db.ref('/' + key + '/messages').limitToLast(1).on('child_added', (snapshot) => {
            res.send({ key: snapshot.key, value: snapshot.val() })
        }))
        .catch(error => res.send(error))

})


app.get('/getdatainfo', (req, res) => {
    db.ref('/').once('value').then(snapshot => {
        res.send(snapshot.val() )
    })
        .catch(error => res.send(error))
})

app.get('/getdatames/:keys', (req, res) => {
    var keys = req.params.keys
    db.ref('/').child(keys).child('messages').once('value', snapshot => {
        res.send(snapshot.val())
    })
        .catch(error => res.send(error))
})

app.get('/app/messages/delete/:keys/:keymes', (req, res) => {
    var keys = req.params.keys
    var keymes = req.params.keymes
    var refdb = db.ref('/').child(keys + '/messages/' + keymes)
    refdb.once('value').then(snapshot => {
        if (snapshot.exists()) {
            refdb.remove(error => res.send(error))
            return res.send({ key: snapshot.key, value: snapshot.val() })
        }else{
            return res.send(false)
        }
    }).catch(error => res.send(error))

})


app.get('/deleteparentmes/:keys', (req, res) => {
    var keys = req.params.keys
    admin.database().ref(keys).once('value').then(snapshot => {
        admin.database().ref().child(keys).remove(error => res.send(error))
        res.send({ key: snapshot.key, value: snapshot.val() })
    }).catch(error => res.send(error))

})


exports.Chat = functions.https.onRequest(app)




