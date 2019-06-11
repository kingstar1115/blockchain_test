void main() {
  List<String> ops = [
    'vote_operation',
    'content_operation',

    'transfer_operation',
    'transfer_to_vesting_operation',
    'withdraw_vesting_operation',

    'account_update_operation',

    'witness_update_operation',
    'account_witness_vote_operation',
    'account_witness_proxy_operation',

    'delete_content_operation',
    'custom_operation',
    'set_withdraw_vesting_route_operation',
    'request_account_recovery_operation',
    'recover_account_operation',
    'change_recovery_account_operation',
    'escrow_transfer_operation',
    'escrow_dispute_operation',
    'escrow_release_operation',
    'escrow_approve_operation',
    'delegate_vesting_shares_operation',
    'account_create_operation',
    'account_metadata_operation',
    'proposal_create_operation',
    'proposal_update_operation',
    'proposal_delete_operation',
    'chain_properties_update_operation',

    // virtual operations:
    'author_reward_operation',
    'curation_reward_operation',
    'content_reward_operation',
    'fill_vesting_withdraw_operation',
    'shutdown_witness_operation',
    'hardfork_operation',
    'content_payout_update_operation',
    'content_benefactor_reward_operation',
    'return_vesting_delegation_operation',

    // VIZ Committee operations:
    'committee_worker_create_request_operation',
    'committee_worker_cancel_request_operation',
    'committee_vote_request_operation',
    // virtual operations:
    'committee_cancel_request_operation',
    'committee_approve_request_operation',
    'committee_payout_request_operation',
    'committee_pay_request_operation',

    'witness_reward_operation',

    // VIZ Invite operations:
    'create_invite_operation',
    'claim_invite_balance_operation',
    'invite_registration_operation',

    'versioned_chain_properties_update_operation',
    'award_operation',
    'receive_award_operation',
    'benefactor_award_operation',

    // VIZ Paid subscription operations:
    'set_paid_subscription_operation',
    'paid_subscribe_operation',
    // virtual operations:
    'paid_subscription_action_operation',
    'cancel_paid_subscription_operation'
  ];

  for (int i = 0; i < ops.length; i++) {
    print('${ops[i]} => $i');
  }
}
