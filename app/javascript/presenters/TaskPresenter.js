import PropTypes from 'prop-types';
import PropTypesPresenter from 'utils/PropTypesPresenter';

export default new PropTypesPresenter(
  {
    id: PropTypes.number,
    name: PropTypes.string,
    description: PropTypes.string,
    author: PropTypes.shape(),
  },
  {
    getName(task) {
      return this.name(task);
    },
    getDescription(task) {
      return this.description(task);
    },
    getAuthor(task) {
      return this.author(task);
    },
  },
);
