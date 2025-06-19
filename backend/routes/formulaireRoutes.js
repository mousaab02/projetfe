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
  });

  it('devrait échouer si des champs sont manquants', async () => {
    const response = await request(app)
      .post('/api/formulaire')
      .send({
        nom: '', 
        email: 'test@example.com',
      });
    expect(response.statusCode).toBe(400);
    expect(response.body).toHaveProperty('message', 'Nom et email sont obligatoires');
  });

  it('devrait échouer avec une erreur volontaire', async () => {
    const response = await request(app)
      .post('/api/formulaire')
      .send({
        nom: 'error',
        email: 'test@example.com',
        message: 'Test erreur volontaire'
      });
    expect(response.statusCode).toBe(400);
    expect(response.body).toHaveProperty('error', 'Erreur test volontaire');
  });
});

afterAll(async () => {
  await mongoose.disconnect();
});
