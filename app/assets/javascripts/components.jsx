// Babel polyfill
import injectTapEventPlugin from 'react-tap-event-plugin';
import 'babel-polyfill';
import 'jquery-ujs';
import RootRoute from './routes/rootRoute.es6';
import NavBar from './components/navbar.es6';
import Footer from './components/footer.es6';
import DeveloperRoute from './routes/developerRoute.es6';
import DevelopersList from './components/developers_list.es6';
import DeveloperShow from './components/developer_show.es6';
import DeveloperEdit from './components/developer_edit.es6';
import CookiesTracker from './components/cookies.es6';
import ReactHelper from './utils/reactHelper.es6';
import renderComponents from './bootstrapper.es6';

injectTapEventPlugin();

ReactHelper.registerComponent({
  NavBar,
  DevelopersList,
  DeveloperShow,
  DeveloperEdit,
  CookiesTracker,
  Footer,
});

ReactHelper.registerRoute({
  RootRoute,
  DeveloperRoute,
});

// Render components to DOM
renderComponents();
