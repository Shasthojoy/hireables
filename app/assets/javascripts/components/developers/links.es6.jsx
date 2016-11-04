/* eslint-disable jsx-a11y/no-static-element-interactions, no-nested-ternary */
/* global $ ga location window Routes */

// Modules
import React, { Component } from 'react';
import Relay from 'react-relay';
import FontIcon from 'material-ui/FontIcon';
import Chip from 'material-ui/Chip';
import Avatar from 'material-ui/Avatar';
import SvgIcon from 'material-ui/SvgIcon';
import { css } from 'aphrodite';

// Stylesheet
import iconStyles from '../styles/icons.es6';

class Links extends Component {
  static openUrl(event, url) {
    event.preventDefault();
    const urlWithProtocol = url.match(/^http[s]*:\/\//) ? url : `http://${url}`;
    window.open(urlWithProtocol);
    event.stopPropagation();
  }

  constructor(props) {
    super(props);
    this.openMail = this.openMail.bind(this);
  }

  openMail(e) {
    e.preventDefault();
    window.location.href = `mailto:${this.props.developer.email}`;
    e.stopPropagation();
  }

  render() {
    return (
      <div className="links">
        <div className={css(iconStyles.links)}>
          {this.props.developer.email && this.props.developer.hireable ?
            <Chip
              className={css(iconStyles.linkIcon)}
              onClick={this.openMail}
              style={{ cursor: 'pointer' }}
            >
              <Avatar
                className={css(iconStyles.iconAvatar)}
                icon={<FontIcon className="material-icons">email</FontIcon>}
              />
              Email
            </Chip> : ''
          }

          {this.props.developer.blog ?
            <Chip
              className={css(iconStyles.linkIcon)}
              style={{ cursor: 'pointer' }}
              onClick={event => Links.openUrl(event, this.props.developer.blog)}
            >
              <Avatar
                className={css(iconStyles.iconAvatar)}
                icon={<FontIcon className="material-icons">web</FontIcon>}
              />
              Website
            </Chip> : ''
          }

          <Chip
            className={css(iconStyles.linkIcon)}
            style={{ cursor: 'pointer' }}
            onClick={event => Links.openUrl(event, this.props.developer.html_url)}
          >
            <Avatar
              className={css(iconStyles.iconAvatar)}
              icon={<FontIcon
                className="muidocs-icon-custom-github link-icon"
              />
              }
            />
            Github
          </Chip>

          {this.props.developer.linkedin ?
            <Chip
              className={css(iconStyles.linkIcon)}
              style={{ cursor: 'pointer' }}
              onClick={event => Links.openUrl(event, this.props.developer.linkedin)}
            >
              <Avatar
                className={css(iconStyles.iconAvatar)}
                icon={
                  (<SvgIcon color="#777" viewBox="0 0 512 512">
                    <path
                      d="M186.4 142.4c0 19-15.3 34.5-34.2 34.5
                      -18.9 0-34.2-15.4-34.2-34.5 0-19 15.3-34.5 34.2-34.5C171.1
                      107.9 186.4 123.4 186.4 142.4zM181.4
                      201.3h-57.8V388.1h57.8V201.3zM273.8
                      201.3h-55.4V388.1h55.4c0 0 0-69.3 0-98 0-26.3
                      12.1-41.9 35.2-41.9 21.3 0 31.5 15 31.5 41.9 0 26.9 0 98
                      0 98h57.5c0
                      0 0-68.2 0-118.3 0-50-28.3-74.2-68-74.2 -39.6
                      0-56.3 30.9-56.3 30.9v-25.2H273.8z"
                    />
                  </SvgIcon>)
                }
              />
              Linkedin
            </Chip> : ''
          }

          {this.props.developer.remote ?
            <Chip
              className={css(iconStyles.linkIcon)}
            >
              <Avatar
                className={css(iconStyles.iconAvatar)}
                icon={<FontIcon className="material-icons">settings_remote</FontIcon>}
              />
              Remote
            </Chip> : ''
          }

          {this.props.developer.relocate ?
            <Chip
              className={css(iconStyles.linkIcon)}
            >
              <Avatar
                className={css(iconStyles.iconAvatar)}
                icon={<FontIcon className="material-icons">location_on</FontIcon>}
              />
              Relocate
            </Chip> : ''
          }
        </div>
      </div>
    );
  }
}

Links.propTypes = {
  developer: React.PropTypes.object,
};

const LinksContainer = Relay.createContainer(
  Links, {
    fragments: {
      developer: () => Relay.QL`
        fragment on Developer {
          blog,
          login,
          html_url,
          email,
          remote,
          linkedin,
          premium,
          relocate,
          html_url,
          hireable,
        }
      `,
    },
  }
);

export default LinksContainer;