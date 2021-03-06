/* global $ */
import React, { Component } from 'react';
import Relay from 'react-relay';
import Avatar from 'material-ui/Avatar';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import IconButton from 'material-ui/IconButton';
import Reply from 'material-ui/svg-icons/content/reply';
import Trash from 'material-ui/svg-icons/action/delete';
import Subject from 'material-ui/svg-icons/action/subject';
import muiTheme from '../theme.es6';
import Receipt from './receipt.es6';
import nameBadge from '../../utils/nameBadge.es6';
import CurrentUser from '../../helpers/currentUser.es6';
import ReplyComposer from './replyComposer.es6';
import LoadingComponent from '../shared/loadingComponent';
import TrashConversation from '../../mutations/mailbox/trashConversation.es6';
import DeleteConversation from '../../mutations/mailbox/deleteConversation.es6';

const currentUser = new CurrentUser();

class Receipts extends Component {
  constructor(props) {
    super(props);
    this.toggleReplyForm = this.toggleReplyForm.bind(this);
    this.handleScrollLoad = this.handleScrollLoad.bind(this);
    this.deleteConversation = this.deleteConversation.bind(this);
    this.loadMore = this.loadMore.bind(this);

    this.state = {
      replying: false,
      loading: false,
      open: false,
    };
  }

  componentDidMount() {
    this.receiptsNode.addEventListener('scroll', this.handleScrollLoad);
  }

  componentWillUnmount() {
    this.receiptsNode.removeEventListener('scroll', this.handleScrollLoad);
  }

  deleteConversation() {
    const onFailure = (transaction) => {
      const error = transaction.getError() || new Error('Mutation failed.');
      let errorMessage;
      if (error.source.errors && Array.isArray(error.source.errors)) {
        errorMessage = error.source.errors[0].message;
      } else {
        errorMessage = error.message;
      }
      this.props.setNotification(errorMessage);
    };

    const onSuccess = (response) => {
      if (response.TrashConversation) {
        this.props.unmountReceipts();
        this.props.setNotification('Conversation moved to trash');
      } else if (response.DeleteConversation) {
        this.props.unmountReceipts();
        this.props.setNotification('Conversation permanently deleted');
      }
    };

    if (this.props.mailbox.type === 'Trash') {
      Relay.Store.commitUpdate(new DeleteConversation({
        id: this.props.conversation.id,
        mailbox_id: this.props.mailbox.id,
      }), { onFailure, onSuccess });
    } else {
      Relay.Store.commitUpdate(new TrashConversation({
        id: this.props.conversation.id,
        mailbox_id: this.props.mailbox.id,
      }), { onFailure, onSuccess });
    }
  }

  toggleReplyForm() {
    this.setState({ replying: !this.state.replying });
  }

  handleScrollLoad() {
    if ($(this.receiptsNode).scrollTop() >
        $(this.receiptsNode).height() -
        $(this.receiptsNode).height() - 50 &&
        !this.state.loading
      ) {
      const { conversation } = this.props;
      if (conversation.receipts.pageInfo.hasNextPage) {
        this.setState({
          loading: true,
        }, () => {
          this.loadMore();
        });
      }
    }
  }

  loadMore() {
    const { relay } = this.props;
    relay.setVariables({
      first: relay.variables.first + 10,
    }, (readyState) => {
      if (readyState.done) {
        this.setState({
          loading: false,
        });
      }
    });
  }

  render() {
    const { conversation } = this.props;
    return (
      <MuiThemeProvider muiTheme={muiTheme}>
        <div
          className="receipts"
          ref={node => (this.receiptsNode = node)}
        >
          <div className="header">
            <h1>
              <Subject className="icon" />
              {conversation.subject} ({conversation.messages_count})
            </h1>
            <div className="actions">
              <IconButton
                tooltip="Reply"
                onClick={this.toggleReplyForm}
              >
                <Reply />
              </IconButton>

              <IconButton
                tooltip="Move to trash"
                onClick={this.deleteConversation}
              >
                <Trash />
              </IconButton>
            </div>
          </div>

          {this.state.replying ?
            <ReplyComposer
              toggleReplyForm={this.toggleReplyForm}
              conversation={conversation}
              setNotification={this.props.setNotification}
            /> : ''
          }

          {conversation.receipts && conversation.receipts.edges.length > 0 ?
            conversation.receipts.edges.map(({ node }) => (
              <Receipt receipt={node} key={node.id} />
            )) :
            <div className="no-result">
              {currentUser.avatar ?
                <Avatar src={currentUser.avatar} /> :
                <Avatar>
                  {nameBadge(currentUser.name)}
                </Avatar>
              }
              <h1>No emails found</h1>
            </div>
          }
          {this.state.loading ? <LoadingComponent cssClass="relative" /> : ''}
        </div>
      </MuiThemeProvider>
    );
  }
}

Receipts.propTypes = {
  conversation: React.PropTypes.object,
  relay: React.PropTypes.object,
  mailbox: React.PropTypes.object,
  unmountReceipts: React.PropTypes.func,
  setNotification: React.PropTypes.func,
};

const ReceiptsContainer = Relay.createContainer(Receipts, {
  initialVariables: {
    first: 10,
  },

  fragments: {
    conversation: () => Relay.QL`
      fragment on Conversation {
        id,
        subject,
        messages_count,
        receipts(first: $first) {
          edges {
            node {
              id,
              ${Receipt.getFragment('receipt')},
            }
          },
          pageInfo {
            hasNextPage,
          },
        }
      }
    `,
  },
});

export default ReceiptsContainer;
