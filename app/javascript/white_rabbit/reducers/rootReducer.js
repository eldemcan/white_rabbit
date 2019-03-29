
import { combineReducers } from 'redux';
import jobReducer from './jobReducer';

const rootReducer = combineReducers({
  jobReducer,
});

export default rootReducer;
