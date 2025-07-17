const request = require('supertest');
const mongoose = require('mongoose');
const app = require('../app');

describe('POST /api/formulaire', () => {
  it('devrait enregistrer un formulaire avec succès', async () => {
    const response = await request(app)
      .post('/api/formulaire')
      .send({
        nom: 'Test Nom',
        email: 'test@example.com',
        message: 'Ceci est un message de test'
      });
    expect(response.statusCode).toBe(201);
    expect(response.body).toHaveProperty('message', 'Formulaire enregistré !');
  }, 15000);

  it('devrait échouer si des champs sont manquants', async () => {
    const response = await request(app)
      .post('/api/formulaire')
      .send({
        nom: '', 
        email: 'test@example.com',
      });
    expect(response.statusCode).toBe(400);
    expect(response.body).toHaveProperty('message', 'Nom et email sont obligatoires');
  }, 15000);
});

// Déconnexion de Mongoose après tous les tests, Important pour fermer proprement la connexion MongoDB après les tests.
afterAll(async () => {
  await mongoose.disconnect();
});
