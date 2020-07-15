import React from 'react';

import store from 'store';
import { Provider } from 'react-redux';

import TaskBoardContainer from 'containers/TaskBoardContainer';
import TaskBoard from 'packs/components/TaskBoard';

const App = () => {
  return (
    <Provider store={store}>
      <TaskBoardContainer>
        {({ board, loadBoard, taskCreate, taskDestroy, loadTask, taskUpdate, сardDragEnd, loadMoreTasks }) => (
          <TaskBoard
            loadBoard={loadBoard}
            board={board}
            taskCreate={taskCreate}
            taskDestroy={taskDestroy}
            loadTask={loadTask}
            taskUpdate={taskUpdate}
            сardDragEnd={сardDragEnd}
            loadMoreTasks={loadMoreTasks}
          />
        )}
      </TaskBoardContainer>
    </Provider>
  );
};

export default App;
