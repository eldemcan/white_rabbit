import ApiClient from './apiClient.jsx';

class JobsApiClient {
  static baseUrl = 'white_rabbit';

  static getTaskTypes() {
    return ApiClient.get(`/${this.baseUrl}/tasks`).then(data => data.json());
  }

  static getRunningJobs() {
    return ApiClient.get(`/${this.baseUrl}/fetch_jobs`).then(data => data.json());
  }

  static postJobParams(payload) {
    return ApiClient.post(`/${this.baseUrl}/create`, payload);
  }

  static killJob(jobId) {
    return ApiClient.post(`/${this.baseUrl}/destroy_job`, { jobId }).then(data => data);
  }

  static addParamsToUrl(url, params) {
    const paramString = Object.keys(params).map(element =>
      `${element}=${params[element]}`
    );

    return `${url}?${paramString}`;
  }
}

export default JobsApiClient;
