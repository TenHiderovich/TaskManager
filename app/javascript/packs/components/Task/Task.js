import React from 'react';
import PropTypes from 'prop-types';

import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';
import EditIcon from '@material-ui/icons/Edit';

import useStyles from './useStyles';

const Task = ({ task, onClick }) => {
  const styles = useStyles();

  const handleClick = () => onClick(task);

  return (
    <Card className={styles.root}>
      <CardHeader title={task.name} />
      <div className={styles.actions}>
        <IconButton aria-label="Edit" onClick={handleClick}>
          <EditIcon fontSize="small" />
        </IconButton>
      </div>
      <CardContent>
        <Typography variant="body2" color="textSecondary" component="p">
          {task.description}
        </Typography>
      </CardContent>
    </Card>
  );
};

Task.propTypes = {
  task: PropTypes.shape().isRequired,
  onClick: PropTypes.func.isRequired,
};

export default Task;