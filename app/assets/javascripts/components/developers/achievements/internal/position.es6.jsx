// Modules
import React, { Component } from 'react';
import Relay from 'react-relay';
import { Card, CardActions, CardTitle, CardText } from 'material-ui/Card';
import moment from 'moment';
import FontIcon from 'material-ui/FontIcon';
import { sanitizeRichText } from '../../../../utils/sanitize.es6';
import AchievementForm from '../form.es6';
import AchievementActions from '../actions.es6';

class Position extends Component {
  constructor(props) {
    super(props);
    this.edit = this.edit.bind(this);
    this.state = {
      editing: false,
    };
  }

  edit(event) {
    if (event) {
      event.preventDefault();
    }
    this.setState({ editing: !this.state.editing });
  }

  render() {
    const { achievement, remove, update } = this.props;

    return (
      <div className={`achievement ${achievement.source_name}`}>
        <div className="achievement-block">
          <div className={`achievement-point ${achievement.source_name}`}>
            <FontIcon
              color="#fff"
              className="material-icons"
              style={{
                fontSize: 20,
                verticalAlign: 'top',
                marginLeft: 5,
              }}
            >
              work
            </FontIcon>
          </div>

          <div className="achievement-content">
            <Card className="achievement-card full-width">
              <div className="achievement-card-content">
                <h2 className="intro">
                  <i className="icon material-icons">work</i>
                  <span>Position</span>
                </h2>

                {achievement.is_owner ?
                  <AchievementActions
                    achievement={achievement}
                    remove={remove}
                    edit={this.edit}
                  /> : ''
                }

                <time className="date">
                  {
                    moment(achievement.date, 'YYYY-MM-DD HH:mm:ss [UTC]')
                    .format('MMMM Do YYYY')
                    .toString()
                  }
                </time>

                {this.state.editing ?
                  <AchievementForm
                    achievement={achievement}
                    update={update}
                    edit={this.edit}
                  /> :
                  <div className="achievement-content">
                    <CardTitle
                      className="achievement-card-header"
                      title={
                        <div className="title">
                          {achievement.title}
                        </div>
                      }
                    />
                    <CardText
                      className="achievement-card-description"
                      dangerouslySetInnerHTML={{
                        __html: sanitizeRichText(achievement.description),
                      }}
                    />
                  </div>
                }

                <CardActions className="meta">
                  <span className="badge">
                    {achievement.category}
                  </span>
                </CardActions>
              </div>
            </Card>
          </div>
        </div>
      </div>
    );
  }
}

Position.propTypes = {
  achievement: React.PropTypes.object,
  remove: React.PropTypes.func,
  update: React.PropTypes.func,
};

const PositionContainer = Relay.createContainer(Position, {
  fragments: {
    achievement: () => Relay.QL`
      fragment on Achievement {
        id,
        title,
        description,
        source_name,
        category,
        developer_id,
        is_owner,
        date,
        ${AchievementActions.getFragment('achievement')},
        ${AchievementForm.getFragment('achievement')},
      }
    `,
  },
});

export default PositionContainer;
