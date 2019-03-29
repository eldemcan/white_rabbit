import * as types from '../constants/jobActionsTypes';

const initialState =
  {
    jobTypes: [],
    jobs: [],
  };

  // TODO : if things get complicated seperate into another reducer
function jobReducer(state = initialState, action) {
  switch (action.type) {
    case types.JOB_TYPES_RECEIVED:
      console.log('Job reducer', action.jobTypes);
      return Object.assign({}, state, { jobTypes: action.jobTypes });
    case types.JOBS_FETCHED:
      return Object.assign({}, state, { jobs: action.jobs });
    default:
      return state;
  }
}

export default jobReducer;
