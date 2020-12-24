defmodule MarketApiWeb.ErrorHelpers do
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(MarketApiWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(MarketApiWeb.Gettext, "errors", msg, opts)
    end
  end
end
