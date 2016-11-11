// Modules
import React, { Component } from 'react';
import Relay from 'react-relay';

// Child Components
import Achievement from './achievement.es6';

class DeveloperAchievements extends Component {
  constructor(props) {
    super(props);
    this.loadMore = this.loadMore.bind(this);
  }

  loadMore() {
    this.props.relay.setVariables({
      first: this.props.relay.variables.first + 20,
    });
  }

  render() {
    const { developer } = this.props;
    return (
      <div className="achievements">
        <h1>Achievements</h1>
        {developer.imports.edges.map(({ node }) => (
          <Achievement achievement={node} key={node.id} />
        ))}
      </div>
    );
  }
}

DeveloperAchievements.propTypes = {
  relay: React.PropTypes.object,
  developer: React.PropTypes.object,
};

const DeveloperAchievementsContainer = Relay.createContainer(DeveloperAchievements, {
  initialVariables: {
    first: 20,
  },
  fragments: {
    developer: () => Relay.QL`
      fragment on Developer {
        id,
        imports(first: $first) {
          edges {
            node {
              id,
              ${Achievement.getFragment('achievement')},
            }
          }
        }
      }
    `,
  },
});

export default DeveloperAchievementsContainer;
