import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';
import KanbanBoard from '@lourenci/react-kanban';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';

import Task from '../Task';
import ColumnHeader from '../ColumnHeader';
import AddPopup from '../AddPopup';
import EditPopup from '../EditPopup';

import useStyles from './useStyles';

const MODES = {
  ADD: 'add',
  NONE: 'none',
  EDIT: 'edit',
};

const TaskBoard = (props) => {
  const { board, loadBoard, taskCreate, taskDestroy, loadTask, taskUpdate, сardDragEnd, loadMoreTasks } = props;
  const [mode, setMode] = useState(MODES.NONE);
  const [openedTaskId, setOpenedTaskId] = useState(null);
  const styles = useStyles();

  useEffect(() => {
    loadBoard();
  }, []);

  // useEffect(() => generateBoard(), [boardCards]);

  const handleOpenAddPopup = () => {
    setMode(MODES.ADD);
  };

  const handleOpenEditPopup = (task) => {
    setOpenedTaskId(task.id);
    setMode(MODES.EDIT);
  };

  const handleClose = () => {
    setMode(MODES.NONE);
    setOpenedTaskId(null);
  };

  const handleTaskCreate = (params) => {
    handleClose();
    return taskCreate(params);
  };

  const loadColumnMore = (...data) => {
    loadMoreTasks(...data);
  };

  const handleCardDragEnd = (task, source, destination) => {
    сardDragEnd(task, source, destination);
  };

  const handleTaskLoad = (id) => {
    return loadTask(id);
  };

  const handleTaskUpdate = (params) => {
    handleClose();
    return taskUpdate(params);
  };

  const handleTaskDestroy = (task) => {
    handleClose();
    return taskDestroy(task);
  };

  return (
    <>
      <KanbanBoard
        disableColumnDrag
        onCardDragEnd={handleCardDragEnd}
        renderColumnHeader={(column) => <ColumnHeader column={column} onLoadMore={loadColumnMore} />}
        renderCard={(card) => <Task onClick={handleOpenEditPopup} task={card} />}
      >
        {board}
      </KanbanBoard>
      {mode === MODES.ADD && <AddPopup onCreateCard={handleTaskCreate} onClose={handleClose} />}
      {mode === MODES.EDIT && (
        <EditPopup
          onLoadCard={handleTaskLoad}
          onCardDestroy={handleTaskDestroy}
          onCardUpdate={handleTaskUpdate}
          onClose={handleClose}
          cardId={openedTaskId}
        />
      )}
      <Fab className={styles.addButton} color="primary" aria-label="add" onClick={handleOpenAddPopup}>
        <AddIcon />
      </Fab>
    </>
  );
};

TaskBoard.propTypes = {
  loadBoard: PropTypes.func.isRequired,
  taskCreate: PropTypes.func.isRequired,
  taskUpdate: PropTypes.func.isRequired,
  taskDestroy: PropTypes.func.isRequired,
  loadTask: PropTypes.func.isRequired,
  сardDragEnd: PropTypes.func.isRequired,
  board: PropTypes.shape({
    columns: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.string.isRequired,
        title: PropTypes.string.isRequired,
        cards: PropTypes.array.isRequired,
        meta: PropTypes.shape({}).isRequired,
      }),
    ),
  }).isRequired,
};

export default TaskBoard;
