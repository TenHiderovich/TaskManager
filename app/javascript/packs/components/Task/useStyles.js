import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(() => ({
  root: {
    width: 250,
    position: 'relative',
  },
  actions: {
    position: 'absolute',
    top: 0,
    right: 0,
  },
}));

export default useStyles;
