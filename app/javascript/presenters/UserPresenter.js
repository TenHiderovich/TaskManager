import PropTypes from 'prop-types';
import PropTypesPresenter from 'utils/PropTypesPresenter';

export default new PropTypesPresenter(
  {
    id: PropTypes.number,
    firstName: PropTypes.string,
    lastName: PropTypes.string,
  },
  {
    fullName(user) {
      return `${this.firstName(user)} ${this.lastName(user)}`;
    },
    getFirstName(user) {
      return this.firstName(user);
    },
    getLastName(user) {
      return this.lastName(user);
    },
  },
);
