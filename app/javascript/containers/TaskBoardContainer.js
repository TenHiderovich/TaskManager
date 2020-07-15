import { useSelector } from 'react-redux';
import { useTasksActions } from 'slices/TasksSlice';

const TaskBoardContainer = (props) => {
  const { children } = props;
  const board = useSelector((state) => state.TasksSlice.board);

  const { loadBoard, taskCreate, taskDestroy, loadTask, taskUpdate, сardDragEnd, loadMoreTasks } = useTasksActions();

  return children({
    board,
    loadBoard,
    taskCreate,
    taskUpdate,
    taskDestroy,
    loadTask,
    сardDragEnd,
    loadMoreTasks,
  });
};

export default TaskBoardContainer;
