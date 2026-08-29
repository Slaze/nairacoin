// Copyright (c) 2026, Nairacoin
// Mint a unique genesis miner tx. Keys are discarded: genesis output unspendable.

#include <iostream>
#include <string>

#include "cryptonote_basic/account.h"
#include "cryptonote_basic/cryptonote_format_utils.h"
#include "cryptonote_core/cryptonote_tx_utils.h"
#include "string_tools.h"

int main()
{
  cryptonote::account_base miner;
  miner.generate();

  cryptonote::transaction tx;
  cryptonote::blobdata extra_nonce;
  const bool ok = cryptonote::construct_miner_tx(
      0, 0, 0, 0, 0,
      miner.get_keys().m_account_address,
      tx, extra_nonce, 1, 1);
  if (!ok)
  {
    std::cerr << "construct_miner_tx failed\n";
    return 1;
  }

  const cryptonote::blobdata blob = cryptonote::tx_to_blob(tx);
  std::cout << epee::string_tools::buff_to_hex_nodelimer(blob) << std::endl;
  return 0;
}
