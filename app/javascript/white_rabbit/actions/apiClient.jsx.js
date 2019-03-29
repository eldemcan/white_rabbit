class ApiClient {

  static get(url, params = {}) {
    return fetch(url, { method: 'GET' })
      .then(response => {
        if (response.status === 200) {
          console.log('response', response);
          return response;
        }
      });
  }

  static post(url, payload = {}) {
    return fetch(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'POST',
      body: JSON.stringify(payload)
    });
  }

}

export default ApiClient;
