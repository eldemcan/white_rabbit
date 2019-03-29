import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { createStore } from 'redux';
import { Provider, connect } from 'react-redux';
import rootReducer from './reducers/rootReducer';
import JobListComponent from './jobListComponent';
import JobCreationContainer from './jobCreationContainer';
import apiClient from './actions/rabbitApiClient';
import JobActions from './actions/jobActions';

const store = createStore(rootReducer);

class Rabbit extends Component {
  render() {
    console.log('mssss');
    return (<JobsContainerWired />);
  }
}

class JobsContainer extends Component {

  componentDidMount() {
    console.log('mounted');
    apiClient.getTaskTypes().then(jobTypes => store.dispatch(JobActions.jobTypesReceived(jobTypes)));
    apiClient.getRunningJobs().then(jobs => store.dispatch(JobActions.jobsReceived(jobs)));
  }

  render() {
    const { jobTypes, jobs } = this.props;
    console.log('Jobs container props', this.props);
    return (
      <div>
        <JobCreationContainer jobTypes = {jobTypes}  />
        <JobListComponent jobs = {jobs} />
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  console.log('rabbit state', state);
  return {
    jobTypes: state.jobReducer.jobTypes,
    jobs: state.jobReducer.jobs,
  };
};

const JobsContainerWired = connect(
  mapStateToProps
)(JobsContainer)

// console.log('Initial state');
// console.log('store', store.getState());
document.addEventListener('DOMContentLoaded', () => {
  console.log('starting...');
  ReactDOM.render(
    <Provider store={store}>
      <Rabbit />
    </Provider>,
    document.body.appendChild(document.createElement('div')),
  )
});
