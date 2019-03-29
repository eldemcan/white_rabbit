import { Table, Button } from 'react-bootstrap';
import React, { Component } from 'react';
import { connect } from 'react-redux';
import apiClient from './actions/rabbitApiClient';
import JobActions from './actions/jobActions';
import ToolkitProvider, { Search } from 'react-bootstrap-table2-toolkit';
import BootstrapTable from 'react-bootstrap-table-next';

class JobListComponent extends Component {

  addButtons(jobs) {
    return (jobs.map(job => {
      job.action = this.createButton(job.attributes.jobId);
      return job;
    }));
  }

  createButton(jobId) {
    return (<Button bsStyle="danger" bsSize="small" onClick={() => this.handleClick(jobId)} >Stop</Button>);
  }

  handleClick(jobId) {
    const { fetchRunningJobs } = this.props;

    apiClient.killJob(jobId).then(() => {
      apiClient.getRunningJobs().then(jobs => fetchRunningJobs(JobActions.jobsReceived(jobs)))
    });
  }

  defineColumns() {
    return  [{
      dataField: 'attributes.jobClass',
      text: 'Task name'
    }, {
      dataField: 'attributes.interval',
      text: 'Inverval'
    }, {
      dataField: 'attributes.params',
      text: 'Params'
    },{
      dataField: 'action' ,
      text: 'Actions',
    }];
  }

  render() {
    const { jobs } = this.props;
    console.log('[JobListComponent] jobs', jobs);
    const { SearchBar } = Search;
    const jobsButtonsAdded = this.addButtons(jobs);
    const am = (props) => {
        return(
          <div>
          <h3>Input something at below input field:</h3>
          <SearchBar {...props.searchProps} />
          <hr />
          <BootstrapTable
            {...props.baseProps}
          />
        </div>
        );
    }
    return (
      <div>
        <ToolkitProvider
          keyField="id"
          data={jobsButtonsAdded}
          columns={this.defineColumns()}
          search
        >
          {
            am
          }
        </ToolkitProvider>
      </div>
    );
  }
}

const mapDispatchToProps = dispatch => {
  return {
    fetchRunningJobs: action => dispatch(action),
  };
}

export default connect(null, mapDispatchToProps)(JobListComponent);
