import * as types from '../constants/jobActionsTypes';

class JobActions {
  static jobTypesReceived(jobTypes) {
    return (
      {
        type: types.JOB_TYPES_RECEIVED,
        jobTypes,
      }
    );
  }

  static jobsReceived(jobs) {
    return (
      {
        type: types.JOBS_FETCHED,
        jobs,
      }
    );
  }
}

export default JobActions;
