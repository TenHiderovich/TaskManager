import { propEq } from 'ramda';
import { createSlice } from '@reduxjs/toolkit';
import { STATES } from 'presenters/TaskPresenter';
import { useDispatch } from 'react-redux';
import { changeColumn } from '@lourenci/react-kanban';

import TaskForm from 'forms/TaskForm';
import TasksRepository from 'repositories/TasksRepository';

const initialState = {
  board: {
    columns: STATES.map((column) => ({
      id: column.key,
      title: column.value,
      cards: [],
      meta: {},
    })),
  },
};

const tasksSlice = createSlice({
  name: 'tasks',
  initialState,
  reducers: {
    loadColumnSuccess(state, { payload }) {
      const { items, meta, columnId } = payload;
      const column = state.board.columns.find(propEq('id', columnId));

      state.board = changeColumn(state.board, column, {
        cards: items,
        meta,
      });

      return state;
    },
  },
});

const { loadColumnSuccess } = tasksSlice.actions;

export default tasksSlice.reducer;

export const useTasksActions = () => {
  const dispatch = useDispatch();

  const loadColumn = (state, page = 1, perPage = 10) => {
    TasksRepository.index({
      q: { stateEq: state },
      page,
      perPage,
    }).then(({ data }) => {
      dispatch(loadColumnSuccess({ ...data, columnId: state }));
    });
  };

  const loadBoard = () => STATES.map(({ key }) => loadColumn(key));

  const taskCreate = (params) => {
    const attributes = TaskForm.attributesToSubmit(params);
    return TasksRepository.create(attributes).then(({ data: { task } }) => {
      loadColumn(task.state);
    });
  };

  const taskUpdate = (params) => {
    const attributes = TaskForm.attributesToSubmit(params);
    return TasksRepository.update(params.id, attributes).then(({ data: { task } }) => {
      loadColumn(task.state);
    });
  };

  const taskDestroy = (task) => {
    return TasksRepository.destroy(task.id).then(() => {
      loadColumn(task.state);
    });
  };

  const loadTask = (id) => {
    return TasksRepository.show(id).then(({ data: { task } }) => task);
  };

  const loadMoreTasks = (state, page = 1, perPage = 10) => {

  };

  const сardDragEnd = (task, source, destination) => {
    const transition = task.transitions.find(({ to }) => destination.toColumnId === to);
    if (!transition) {
      return;
    }

    TasksRepository.update(task.id, { task: { stateEvent: transition.event } })
      .then(() => {
        loadColumn(destination.toColumnId);
        loadColumn(source.fromColumnId);
      })
      .catch((error) => {
        alert(`Move failed! ${error.message}`);
      });
  };

  return {
    loadBoard,
    taskCreate,
    taskDestroy,
    loadTask,
    taskUpdate,
    сardDragEnd,
    loadMoreTasks,
  };
};

// const loadColumnMore = (state, page = 1, perPage = 10) => {
//   loadColumn(state, page, perPage).then(({ data }) => {
//     setBoardCards((prevState) => {
//       const { cards } = prevState[state];
//       return {
//         ...prevState,
//         [state]: {
//           cards: [...cards, ...data.items],
//           meta: data.meta,
//         },
//       };
//     });
//   });
// };

// const handleCardDragEnd = (task, source, destination) => {
//   const transition = task.transitions.find(({ to }) => destination.toColumnId === to);
//   if (!transition) {
//     return null;
//   }

//   return TasksRepository.update(task.id, { task: { stateEvent: transition.event } })
//     .then(() => {
//       loadColumnInitial(destination.toColumnId);
//       loadColumnInitial(source.fromColumnId);
//     })
//     .catch((error) => {
//       alert(`Move failed! ${error.message}`);
//     });
// };

// const handleTaskUpdate = (params) => {
//   const attributes = TaskForm.attributesToSubmit(params);
//   return TasksRepository.update(params.id, attributes).then(({ data: { task } }) => {
//     loadColumnInitial(task.state);
//     handleClose();
//   });
// };

// const handleTaskDestroy = (task) => {
//   return TasksRepository.destroy(task.id).then(() => {
//     loadColumnInitial(task.state);
//     handleClose();
//   });
// };
