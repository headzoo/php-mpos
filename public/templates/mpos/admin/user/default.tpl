<script language="javascript">
    function storeFee(id) {
      $.ajax({
       type: "POST",
       url: "{$smarty.server.PHP_SELF}",
       data: "page={$smarty.request.page|escape}&action={$smarty.request.action|escape}&do=fee&account_id=" + id,
     });
    }
    function storeLock(id) {
      $.ajax({
       type: "POST",
       url: "{$smarty.server.PHP_SELF}",
       data: "page={$smarty.request.page|escape}&action={$smarty.request.action|escape}&do=lock&account_id=" + id,
     });
    }
    function storeAdmin(id) {
      $.ajax({
       type: "POST",
       url: "{$smarty.server.PHP_SELF}",
       data: "page={$smarty.request.page|escape}&action={$smarty.request.action|escape}&do=admin&account_id=" + id,
     });
    }
</script>


<article class="module width_full">
  <header>
    <h3>User Information</h3>
    <div class="submit_link">{include file="global/pagination.tpl"}</div>
  </header>
<table width="100%" class="tablesorterpager">
  <thead>
    <tr>
      <th align="center">ID</th>
      <th align="left">Username</th>
      <th align="left">E-Mail</th>
      <th align="right">Shares&nbsp;&nbsp;</th>
      <th align="right">Hashrate&nbsp;&nbsp;</th>
{if $GLOBAL.config.payout_system != 'pps'}
      <th align="right">Est. Donation&nbsp;&nbsp;</th>
      <th align="right">Est. Payout&nbsp;&nbsp;&nbsp;</th>
{else}
      <th align="right" colspan="2">Est. 24 Hours&nbsp;&nbsp;&nbsp;</th>
{/if}
      <th align="right">Balance&nbsp;&nbsp;&nbsp;</th>
      <th align="center">Admin</th>
      <th align="center">Locked</th>
      <th align="center">No Fees</th>
    </tr>
  </thead>
  <tbody>
{nocache}
{section name=user loop=$USERS|default}
    <tr>
      <td align="center">{$USERS[user].id}</td>
      <td align="left"><a href="{$smarty.server.PHP_SELF}?page=account&action=inbox&account_id={$USERS[user].id}&do=send" title="Send Message">{$USERS[user].username|escape}</a></td>
      <td align="left">{$USERS[user].email|escape}</td>
      <td align="right">{$USERS[user].shares.valid}</td>
      <td align="right">{$USERS[user].hashrate}</td>
{if $GLOBAL.config.payout_system != 'pps'}
      <td align="right">{$USERS[user].estimates.donation|number_format:"8"}</td>
      <td align="right">{$USERS[user].estimates.payout|number_format:"8"}</td>
{else}
      <td align="right" colspan="2">{$USERS[user].estimates.hours24|number_format:"8"}</td>
{/if}
      <td align="right">{$USERS[user].balance|number_format:"8"}</td>
      <td align="center">
        <input type="hidden" name="admin[{$USERS[user].id}]" value="0"/>
        <input type="checkbox" onclick="storeAdmin({$USERS[user].id})" name="admin[{$USERS[user].id}]" value="1" id="admin[{$USERS[user].id}]" {if $USERS[user].is_admin}checked{/if} />
        <label for="admin[{$USERS[user].id}]"></label>
      </td>
      <td align="center">
        <input type="hidden" name="locked[{$USERS[user].id}]" value="0"/>
        <input type="checkbox" onclick="storeLock({$USERS[user].id})" name="locked[{$USERS[user].id}]" value="1" id="locked[{$USERS[user].id}]" {if $USERS[user].is_locked}checked{/if} />
        <label for="locked[{$USERS[user].id}]"></label>
      </td>
      <td align="center">
        <input type="hidden" name="nofee[{$USERS[user].id}]" value="0"/>
        <input type="checkbox" onclick="storeFee({$USERS[user].id})" name="nofee[{$USERS[user].id}]" value="1" id="nofee[{$USERS[user].id}]" {if $USERS[user].no_fees}checked{/if} />
        <label for="nofee[{$USERS[user].id}]"></label>
      </td>
    </tr>
{sectionelse}
  <tr>
    <td colspan="10"></td>
  </tr>
{/section}
{/nocache}
  </tbody>
  <tfoot>
    <tr>
      <th align="center">ID</th>
      <th align="left">Username</th>
      <th align="left">E-Mail</th>
      <th align="right">Shares&nbsp;&nbsp;</th>
      <th align="right">Hashrate&nbsp;&nbsp;</th>
{if $GLOBAL.config.payout_system != 'pps'}
      <th align="right">Est. Donation&nbsp;&nbsp;</th>
      <th align="right">Est. Payout&nbsp;&nbsp;&nbsp;</th>
{else}
      <th align="right" colspan="2">Est. 24 Hours&nbsp;&nbsp;&nbsp;</th>
{/if}
      <th align="right">Balance&nbsp;&nbsp;&nbsp;</th>
      <th align="center">Admin</th>
      <th align="center">Locked</th>
      <th align="center">No Fees</th>
    </tr>
  </tfoot>
</table>
  <footer>
    <div class="submit_link">
    <form action="{$smarty.server.PHP_SELF}" method="POST" id='query'>
      <input type="hidden" name="page" value="{$smarty.request.page|escape}">
      <input type="hidden" name="action" value="{$smarty.request.action|escape}">
      <input type="text" class="pin" name="query" value="{$smarty.request.query|default:"%"|escape}">
      <input type="submit" value="Query" class="alt_btn">
    </form>
    </div>
  </footer>
</article>
